
slot_coalesce_alloca.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movl	$0x40, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	leaq	(%rdx), %rax
               	movl	$0x74, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x75, %eax
               	movq	%rax, 0x8(%rdx)
               	movl	$0x76, %eax
               	movq	%rax, 0x10(%rdx)
               	movl	$0x77, %eax
               	movq	%rax, 0x18(%rdx)
               	movl	$0x78, %eax
               	movq	%rax, 0x20(%rdx)
               	movl	$0x79, %eax
               	movq	%rax, 0x28(%rdx)
               	movl	$0x7a, %eax
               	movq	%rax, 0x30(%rdx)
               	movl	$0x7b, %eax
               	movq	%rax, 0x38(%rdx)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	movslq	%eax, %rsi
               	movq	%rsi, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rdi
               	leaq	0x1(%rsi), %r8
               	movslq	%r8d, %r8
               	imulq	$0x74, %r8, %r8
               	movq	%r8, (%rdi)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	movslq	%eax, %rsi
               	movq	%rsi, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdi, %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0xd0(%rbp), %rsp
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rsi
               	leaq	0x74(%rcx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0xd0(%rbp), %rsp
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0xd0(%rbp), %rsp
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
