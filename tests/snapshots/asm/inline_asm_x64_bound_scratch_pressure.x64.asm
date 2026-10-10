
inline_asm_x64_bound_scratch_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	leaq	<rip>, %rbx      # <addr>
               	movl	$0x5, %r10d
               	leaq	<rip>, %r11      # <addr>
               	movl	$0x1, %r9d
               	movq	%r10, (%r11,%r9,8)
               	movq	0x8(%rbx), %r9
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
               	movq	(%rdi), %rax
               	movq	%rax, %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x8(%rdi), %rax
               	imulq	%rsi, %rax
               	movq	0x10(%rdi), %rcx
               	imulq	%rsi, %rcx
               	movq	0x18(%rdi), %rdx
               	movq	%rdx, %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x20(%rdi), %rdx
               	imulq	%rsi, %rdx
               	movq	0x28(%rdi), %r8
               	imulq	%rsi, %r8
               	movq	0x30(%rdi), %r9
               	imulq	%rsi, %r9
               	movq	0x38(%rdi), %rbx
               	imulq	%rsi, %rbx
               	movq	0x40(%rdi), %r12
               	imulq	%rsi, %r12
               	movq	0x48(%rdi), %r13
               	imulq	%rsi, %r13
               	movq	0x50(%rdi), %r14
               	imulq	%rsi, %r14
               	movq	0x58(%rdi), %r15
               	imulq	%rsi, %r15
               	movq	0x60(%rdi), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x68(%rdi), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %r10
               	movq	0x58(%rsp), %rsi
               	imulq	%r10, %rsi
               	movq	0x78(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x80(%rdi), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x88(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %rdi
               	addq	%rdx, %rdi
               	addq	%r8, %rdx
               	addq	%r9, %r8
               	addq	%rbx, %r9
               	addq	%r12, %rbx
               	addq	%r13, %r12
               	addq	%r14, %r13
               	addq	%r15, %r14
               	addq	0x78(%rsp), %r15
               	movq	0x78(%rsp), %r10
               	addq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	%rsi, %r10
               	movq	%r10, 0x70(%rsp)
               	addq	%rdi, %rsi
               	movq	0x68(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x60(%rsp)
               	addq	0x68(%rsp), %rcx
               	movl	$0x1, %eax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %rdi
               	movq	%r8, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %rdx
               	movq	%r9, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %r8
               	movq	%rbx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %r9
               	movq	%r12, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %rbx
               	movq	%r13, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %r12
               	movq	%r14, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %r13
               	movq	%r15, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %r14
               	movq	0x78(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %r15
               	movq	0x70(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x78(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rsi, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rdi, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %rsi
               	movq	0x60(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x68(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rax, %r10
               	movq	0x68(%rsp), %rax
               	xorq	%r10, %rax
               	addq	%rax, %rcx
               	movl	$0x2, %eax
               	movq	%rdx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %rdi
               	movq	%r8, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rdx, %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r9, %rdx
               	xorq	%rax, %rdx
               	leaq	(%r8,%rdx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %rdx
               	xorq	%rax, %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%r10, 0x30(%rsp)
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
               	movq	0x78(%rsp), %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %r15
               	movq	0x70(%rsp), %rdx
               	xorq	%rax, %rdx
               	movq	0x78(%rsp), %r10
               	addq	%rdx, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rsi, %rdx
               	xorq	%rax, %rdx
               	movq	0x70(%rsp), %r10
               	addq	%rdx, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rdi, %rdx
               	xorq	%rax, %rdx
               	addq	%rdx, %rsi
               	movq	0x60(%rsp), %rdx
               	xorq	%rax, %rdx
               	movq	%rdx, %r10
               	movq	0x68(%rsp), %rdx
               	addq	%r10, %rdx
               	movq	%rcx, %r8
               	xorq	%rax, %r8
               	movq	0x60(%rsp), %r10
               	addq	%r8, %r10
               	movq	%r10, 0x68(%rsp)
               	xorq	%rdx, %rax
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movq	0x58(%rsp), %r10
               	movq	0x50(%rsp), %r11
               	movq	0x48(%rsp), %r9
               	addq	%r10, %rcx
               	addq	%r11, %rcx
               	addq	%r9, %rcx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rax,%rax,4), %rax
               	addq	%rcx, %rax
               	imulq	$0x7, %rdi, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	imulq	$0xd, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	imulq	$0x11, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x13, %rbx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x17, %r12, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1d, %r13, %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %r14, %rcx
               	addq	%rcx, %rax
               	imulq	$0x25, %r15, %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x29, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	imulq	$0x2b, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x2f, %rsi, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rcx
               	leaq	(%rax,%rax,2), %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x12, %eax
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movq	0x10(%rax), %rdx
               	movq	0x18(%rax), %rcx
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %r9
               	callq	<addr>
               	cmpq	$0xbd, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movq	0x10(%rax), %rdx
               	movq	0x18(%rax), %rcx
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %r9
               	callq	<addr>
               	cmpq	$0x122, %rax            # imm = 0x122
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	leaq	<rip>, %rax      # <addr>
               	movq	0x10(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x3ad34, %rax          # imm = 0x3AD34
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
