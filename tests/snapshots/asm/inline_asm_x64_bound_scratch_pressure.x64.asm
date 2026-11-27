
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
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	0x18(%rdi), %rcx
               	imulq	%rsi, %rcx
               	movq	0x20(%rdi), %rax
               	imulq	%rsi, %rax
               	leaq	(%rcx,%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x28(%rdi), %rcx
               	imulq	%rsi, %rcx
               	leaq	(%rax,%rcx), %r14
               	movq	0x30(%rdi), %rax
               	imulq	%rsi, %rax
               	leaq	(%rcx,%rax), %r13
               	movq	0x38(%rdi), %rcx
               	imulq	%rsi, %rcx
               	leaq	(%rax,%rcx), %r12
               	movq	0x40(%rdi), %rax
               	imulq	%rsi, %rax
               	leaq	(%rcx,%rax), %rbx
               	movq	0x48(%rdi), %rcx
               	imulq	%rsi, %rcx
               	leaq	(%rax,%rcx), %r11
               	movq	0x50(%rdi), %rax
               	imulq	%rsi, %rax
               	leaq	(%rcx,%rax), %r10
               	movq	0x58(%rdi), %rcx
               	imulq	%rsi, %rcx
               	leaq	(%rax,%rcx), %r9
               	movq	0x60(%rdi), %rax
               	imulq	%rsi, %rax
               	leaq	(%rcx,%rax), %r8
               	movq	0x68(%rdi), %rcx
               	imulq	%rsi, %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	0x70(%rdi), %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movq	%rax, %r15
               	addq	0x70(%rsp), %r15
               	movq	%r15, 0x68(%rsp)
               	movl	$0x1, %eax
               	movq	0x68(%rsp), %r15
               	xorq	%rax, %r15
               	addq	%rcx, %r15
               	xorq	%rax, %rcx
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rdx,%rcx), %r10
               	movq	%r10, 0x78(%rsp)
               	xorq	%rax, %rdx
               	addq	%r8, %rdx
               	xorq	%rax, %r8
               	addq	%r9, %r8
               	xorq	%rax, %r9
               	movq	0x38(%rsp), %r10
               	addq	%r10, %r9
               	xorq	%rax, %r10
               	addq	%r11, %r10
               	xorq	%rax, %r11
               	addq	%rbx, %r11
               	xorq	%rax, %rbx
               	addq	%r12, %rbx
               	xorq	%rax, %r12
               	addq	%r13, %r12
               	xorq	%rax, %r13
               	addq	%r14, %r13
               	xorq	%rax, %r14
               	movq	%r10, 0x38(%rsp)
               	movq	%r14, %r10
               	movq	0x70(%rsp), %r14
               	addq	%r10, %r14
               	movq	%r14, %rcx
               	xorq	%rax, %rcx
               	movq	0x68(%rsp), %r10
               	addq	%rcx, %r10
               	movq	%r10, 0x70(%rsp)
               	movl	$0x2, %ecx
               	movq	0x70(%rsp), %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%r15, %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	xorq	%rcx, %r15
               	movq	%r15, %r10
               	movq	0x78(%rsp), %r15
               	addq	%r10, %r15
               	movq	0x78(%rsp), %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rdx, %r10
               	addq	0x78(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	xorq	%rcx, %rdx
               	leaq	(%r8,%rdx), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	%rcx, %r8
               	leaq	(%r9,%r8), %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%rcx, %r9
               	movq	0x38(%rsp), %r10
               	leaq	(%r10,%r9), %r8
               	movq	%r8, 0x50(%rsp)
               	xorq	%rcx, %r10
               	leaq	(%r11,%r10), %r9
               	movq	%r9, 0x48(%rsp)
               	xorq	%rcx, %r11
               	leaq	(%rbx,%r11), %r10
               	movq	%r10, 0x40(%rsp)
               	xorq	%rcx, %rbx
               	addq	%r12, %rbx
               	xorq	%rcx, %r12
               	addq	%r13, %r12
               	xorq	%rcx, %r13
               	leaq	(%r14,%r13), %r9
               	movq	%r9, %rdx
               	xorq	%rcx, %rdx
               	movq	0x70(%rsp), %r13
               	addq	%rdx, %r13
               	movq	0x10(%rdi), %rdx
               	imulq	%rsi, %rdx
               	movq	(%rdi), %r10
               	imulq	%rsi, %r10
               	movq	0x8(%rdi), %r8
               	imulq	%rsi, %r8
               	addq	%r8, %r10
               	leaq	(%r8,%rdx), %rsi
               	leaq	(%rdx,%r10), %r8
               	movq	%r8, %rdx
               	xorq	%rax, %rdx
               	addq	%rsi, %rdx
               	xorq	%rax, %rsi
               	addq	%r10, %rsi
               	xorq	%rsi, %rax
               	addq	%r8, %rax
               	movq	%rax, %r8
               	xorq	%rcx, %r8
               	addq	%rdx, %r8
               	xorq	%rcx, %rdx
               	addq	%rsi, %rdx
               	xorq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rdi), %rcx
               	movq	0x80(%rdi), %rsi
               	movq	0x88(%rdi), %rdi
               	xorl	%r14d, %r14d
               	movq	%rcx, %r10
               	movq	%r14, %rcx
               	addq	%r10, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%rdx, %rcx
               	leaq	(%r8,%r8,2), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rax,%rax,4), %rax
               	addq	%rcx, %rax
               	imulq	$0x7, %r9, %rcx
               	addq	%rcx, %rax
               	imulq	$0xb, %r12, %rcx
               	addq	%rcx, %rax
               	imulq	$0xd, %rbx, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0x11, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	imulq	$0x13, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	imulq	$0x17, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	imulq	$0x1d, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	imulq	$0x1f, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x25, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x29, %r15, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	imulq	$0x2b, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x2f, %r13, %rcx
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
               	movq	<rip>, %rsi # <addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x3ad34, %rax          # imm = 0x3AD34
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x98, %rsp
               	retq
