
init_subdesignator_multi_dim.x64:	file format elf64-x86-64

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

<check>:
               	xorq	%rax, %rax
               	movzwq	(%rdi), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzwq	0x2(%rdi), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movzwq	0xa(%rdi), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x24(%rdi), %rax
               	cmpq	$0x5, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x2c(%rdi), %rax
               	cmpq	$0x6, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x98(%rdi), %rax
               	cmpq	$0x9, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movzwq	0x6(%rdi), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x18(%rdi), %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x3c(%rdi), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1f0, %rsp            # imm = 0x1F0
               	leaq	<rip>, %rdi
               	leaq	-0x1e0(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdi), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rdi), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x28(%rdi), %rcx
               	movq	%rcx, 0x28(%rax)
               	movq	0x30(%rdi), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	0x38(%rdi), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	0x40(%rdi), %rcx
               	movq	%rcx, 0x40(%rax)
               	movq	0x48(%rdi), %rcx
               	movq	%rcx, 0x48(%rax)
               	movq	0x50(%rdi), %rcx
               	movq	%rcx, 0x50(%rax)
               	movq	0x58(%rdi), %rcx
               	movq	%rcx, 0x58(%rax)
               	movq	0x60(%rdi), %rcx
               	movq	%rcx, 0x60(%rax)
               	movq	0x68(%rdi), %rcx
               	movq	%rcx, 0x68(%rax)
               	movq	0x70(%rdi), %rcx
               	movq	%rcx, 0x70(%rax)
               	movq	0x78(%rdi), %rcx
               	movq	%rcx, 0x78(%rax)
               	movq	0x80(%rdi), %rcx
               	movq	%rcx, 0x80(%rax)
               	movq	0x88(%rdi), %rcx
               	movq	%rcx, 0x88(%rax)
               	movq	0x90(%rdi), %rcx
               	movq	%rcx, 0x90(%rax)
               	movzbq	0x98(%rdi), %rcx
               	movb	%cl, 0x98(%rax)
               	movzbq	0x99(%rdi), %rcx
               	movb	%cl, 0x99(%rax)
               	movzbq	0x9a(%rdi), %rcx
               	movb	%cl, 0x9a(%rax)
               	movzbq	0x9b(%rdi), %rcx
               	movb	%cl, 0x9b(%rax)
               	popq	%rcx
               	leaq	-0x140(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, 0x40(%rax)
               	movq	%rcx, 0x48(%rax)
               	movq	%rcx, 0x50(%rax)
               	movq	%rcx, 0x58(%rax)
               	movq	%rcx, 0x60(%rax)
               	movq	%rcx, 0x68(%rax)
               	movq	%rcx, 0x70(%rax)
               	movq	%rcx, 0x78(%rax)
               	movq	%rcx, 0x80(%rax)
               	movq	%rcx, 0x88(%rax)
               	movq	%rcx, 0x90(%rax)
               	movl	%ecx, 0x98(%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movzwq	(%rax), %rax
               	leaq	-0x140(%rbp), %rcx
               	movw	%ax, (%rcx)
               	leaq	-0x1e0(%rbp), %rax
               	movzwq	0x2(%rax), %rcx
               	leaq	-0x140(%rbp), %rax
               	movw	%cx, 0x2(%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movzwq	0xa(%rax), %rcx
               	leaq	-0x140(%rbp), %rax
               	movw	%cx, 0xa(%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movslq	0x24(%rax), %rcx
               	leaq	-0x140(%rbp), %rax
               	movl	%ecx, 0x24(%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movslq	0x2c(%rax), %rcx
               	leaq	-0x140(%rbp), %rax
               	movl	%ecx, 0x2c(%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movslq	0x98(%rax), %rcx
               	leaq	-0x140(%rbp), %rax
               	movl	%ecx, 0x98(%rax)
               	leaq	-0xa0(%rbp), %rax
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
               	movq	0x60(%rcx), %rdx
               	movq	%rdx, 0x60(%rax)
               	movq	0x68(%rcx), %rdx
               	movq	%rdx, 0x68(%rax)
               	movq	0x70(%rcx), %rdx
               	movq	%rdx, 0x70(%rax)
               	movq	0x78(%rcx), %rdx
               	movq	%rdx, 0x78(%rax)
               	movq	0x80(%rcx), %rdx
               	movq	%rdx, 0x80(%rax)
               	movq	0x88(%rcx), %rdx
               	movq	%rdx, 0x88(%rax)
               	movq	0x90(%rcx), %rdx
               	movq	%rdx, 0x90(%rax)
               	movzbq	0x98(%rcx), %rdx
               	movb	%dl, 0x98(%rax)
               	movzbq	0x99(%rcx), %rdx
               	movb	%dl, 0x99(%rax)
               	movzbq	0x9a(%rcx), %rdx
               	movb	%dl, 0x9a(%rax)
               	movzbq	0x9b(%rcx), %rdx
               	movb	%dl, 0x9b(%rax)
               	popq	%rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	leaq	-0x140(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movslq	0x54(%rax), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x6c(%rax), %rax
               	cmpq	$0x3, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movzwq	0x8(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	0x98(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
