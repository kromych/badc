
inline_asm_x64_bound_scratch_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<store_constants>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%r9, %rax
               	movq	%rdi, %rbx
               	xorq	%rax, %rbx
               	movl	$0x5, %r10d
               	leaq	<rip>, %r11 # <addr>
               	movl	$0x1, %r9d
               	movq	%r10, (%r11,%r9,8)
               	movq	<rip>, %r9 # <addr>
               	shlq	%rdi
               	addq	%r9, %rdi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rdi, %rsi
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rsi, %rdx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	imulq	$0xb, %r8, %rdx
               	addq	%rdx, %rcx
               	imulq	$0xd, %rax, %rax
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<add_constants>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%r8, %rax
               	movq	%r9, %rbx
               	movl	$0x64, %r12d
               	movl	$0x1, %r10d
               	movl	$0x2, %r11d
               	movl	$0x3, %r9d
               	addq	%r10, %r12
               	addq	%r11, %r12
               	addq	%r9, %r12
               	shlq	%rdi
               	addq	%r12, %rdi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rdi, %rsi
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rsi, %rdx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	imulq	$0xb, %rax, %rax
               	addq	%rcx, %rax
               	imulq	$0xd, %rbx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<add_spilled>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	(%rdi), %r10
               	movq	%r10, 0x80(%rsp)
               	imulq	%rsi, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x8(%rdi), %rax
               	imulq	%rsi, %rax
               	movq	0x10(%rdi), %rcx
               	imulq	%rsi, %rcx
               	movq	0x18(%rdi), %r10
               	movq	%r10, 0x78(%rsp)
               	imulq	%rsi, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x20(%rdi), %rdx
               	imulq	%rsi, %rdx
               	movq	0x28(%rdi), %r8
               	imulq	%rsi, %r8
               	movq	0x30(%rdi), %r9
               	imulq	%rsi, %r9
               	movq	0x38(%rdi), %r10
               	imulq	%rsi, %r10
               	movq	0x40(%rdi), %r11
               	imulq	%rsi, %r11
               	movq	0x48(%rdi), %rbx
               	imulq	%rsi, %rbx
               	movq	0x50(%rdi), %r12
               	imulq	%rsi, %r12
               	movq	0x58(%rdi), %r13
               	imulq	%rsi, %r13
               	movq	0x60(%rdi), %r14
               	imulq	%rsi, %r14
               	movq	0x68(%rdi), %r15
               	imulq	%rsi, %r15
               	movq	%r10, 0x38(%rsp)
               	movq	0x70(%rdi), %r10
               	movq	%r10, 0x88(%rsp)
               	imulq	%rsi, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x78(%rdi), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x80(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x88(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rsp), %rsi
               	addq	%rdx, %rsi
               	addq	%r8, %rdx
               	leaq	(%r8,%r9), %rdi
               	movq	0x38(%rsp), %r10
               	leaq	(%r9,%r10), %r8
               	leaq	(%r10,%r11), %r9
               	leaq	(%r11,%rbx), %r10
               	leaq	(%rbx,%r12), %r11
               	leaq	(%r12,%r13), %rbx
               	leaq	(%r13,%r14), %r12
               	leaq	(%r14,%r15), %r13
               	movq	%r15, %r14
               	addq	0x88(%rsp), %r14
               	movq	0x88(%rsp), %r15
               	addq	%rsi, %r15
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x88(%rsp)
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x80(%rsp)
               	addq	0x88(%rsp), %rcx
               	movl	$0x1, %eax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %rsi
               	movq	%rdi, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %rdx
               	movq	%r8, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %rdi
               	movq	%r9, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %r8
               	movq	0x38(%rsp), %r10
               	movq	%r11, 0x38(%rsp)
               	movq	%r10, %r11
               	xorq	%rax, %r11
               	movq	%r11, 0x78(%rsp)
               	addq	0x78(%rsp), %r9
               	movq	0x38(%rsp), %r11
               	movq	%r10, 0x38(%rsp)
               	movq	%r11, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %r11
               	movq	%r12, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %rbx
               	movq	%r13, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %r12
               	movq	%r14, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %r13
               	movq	%r15, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %r14
               	movq	%rsi, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %r15
               	movq	0x80(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x88(%rsp), %r10
               	addq	0x78(%rsp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x80(%rsp), %r10
               	addq	0x78(%rsp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	%rax, %r10
               	movq	0x88(%rsp), %rax
               	xorq	%r10, %rax
               	addq	%rax, %rcx
               	movl	$0x2, %eax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %rsi
               	movq	%rdi, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rdx, %r10
               	addq	0x78(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%r8, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %rdi
               	movq	%r9, %rdx
               	xorq	%rax, %rdx
               	leaq	(%r8,%rdx), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, %rdx
               	xorq	%rax, %rdx
               	leaq	(%r9,%rdx), %r8
               	movq	%r8, 0x50(%rsp)
               	movq	%r11, %rdx
               	xorq	%rax, %rdx
               	leaq	(%r10,%rdx), %r9
               	movq	%r9, 0x48(%rsp)
               	movq	%rbx, %rdx
               	xorq	%rax, %rdx
               	leaq	(%r11,%rdx), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r12, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %rbx
               	movq	%r13, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %r12
               	movq	%r14, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %r13
               	movq	%r15, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %r14
               	movq	%rsi, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %r15
               	movq	0x80(%rsp), %rdx
               	xorq	%rax, %rdx
               	movq	%rdx, %r10
               	movq	0x88(%rsp), %rdx
               	addq	%r10, %rdx
               	movq	%rcx, %r8
               	xorq	%rax, %r8
               	movq	0x80(%rsp), %r10
               	addq	%r8, %r10
               	movq	%r10, 0x88(%rsp)
               	xorq	%rdx, %rax
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movq	0x70(%rsp), %r10
               	movq	0x68(%rsp), %r11
               	movq	0x60(%rsp), %r9
               	addq	%r10, %rcx
               	addq	%r11, %rcx
               	addq	%r9, %rcx
               	addq	%rdx, %rcx
               	movq	0x88(%rsp), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rax,%rax,4), %rax
               	addq	%rcx, %rax
               	imulq	$0x7, %rsi, %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0xd, %rdi, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	imulq	$0x11, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	imulq	$0x13, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	imulq	$0x17, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0x1d, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rbx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x25, %r12, %rcx
               	addq	%rcx, %rax
               	imulq	$0x29, %r13, %rcx
               	addq	%rcx, %rax
               	imulq	$0x2b, %r14, %rcx
               	addq	%rcx, %rax
               	imulq	$0x2f, %r15, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	subq	$0x98, %rsp
               	xorl	%eax, %eax
               	leaq	(%rax,%rax,2), %rdx
               	incq	%rdx
               	movq	%rdx, (%rsp,%rax,8)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x12, %eax
               	jl	<addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	callq	<addr>
               	cmpq	$0xc4, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	callq	<addr>
               	cmpq	$0x122, %rax            # imm = 0x122
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x3ad34, %rax          # imm = 0x3AD34
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x98, %rsp
               	retq
