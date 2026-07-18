
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x260, %rsp            # imm = 0x260
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb0(%rbp), %rdx
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	%esi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x28, %rcx
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movl	(%rax), %ecx
               	leaq	-0xb0(%rbp), %rax
               	movl	0x9c(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0xc0(%rbp)
               	movl	-0xc0(%rbp), %eax
               	leaq	-0x128(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	movq	0x50(%rcx), %rdx
               	movq	%rdx, 0x50(%rax)
               	movq	0x58(%rcx), %rdx
               	movq	%rdx, 0x58(%rax)
               	movzbq	0x60(%rcx), %rdx
               	movb	%dl, 0x60(%rax)
               	movzbq	0x61(%rcx), %rdx
               	movb	%dl, 0x61(%rax)
               	movzbq	0x62(%rcx), %rdx
               	movb	%dl, 0x62(%rax)
               	movzbq	0x63(%rcx), %rdx
               	movb	%dl, 0x63(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%edx, %esi
               	leaq	-0x128(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x19, %rcx
               	jl	<addr>
               	movl	%edx, %r8d
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1d8(%rbp), %rdx
               	movl	$0x12345678, %esi       # imm = 0x12345678
               	movl	%esi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x28, %rcx
               	jl	<addr>
               	leaq	-0x1d8(%rbp), %rax
               	movl	(%rax), %ecx
               	leaq	-0x1d8(%rbp), %rax
               	movl	0x9c(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x1e8(%rbp)
               	movl	-0x1e8(%rbp), %eax
               	leaq	-0x250(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	movq	0x50(%rcx), %rdx
               	movq	%rdx, 0x50(%rax)
               	movq	0x58(%rcx), %rdx
               	movq	%rdx, 0x58(%rax)
               	movzbq	0x60(%rcx), %rdx
               	movb	%dl, 0x60(%rax)
               	movzbq	0x61(%rcx), %rdx
               	movb	%dl, 0x61(%rax)
               	movzbq	0x62(%rcx), %rdx
               	movb	%dl, 0x62(%rax)
               	movzbq	0x63(%rcx), %rdx
               	movb	%dl, 0x63(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%edx, %esi
               	leaq	-0x250(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x19, %rcx
               	jl	<addr>
               	movl	%edx, %ecx
               	movl	%r8d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movl	%ecx, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
