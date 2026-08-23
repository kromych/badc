
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
               	movzwq	0x2(%rdi), %rcx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzwq	0xa(%rdi), %rcx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x24(%rdi), %rcx
               	cmpl	$0x5, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x2c(%rdi), %rcx
               	cmpl	$0x6, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x98(%rdi), %rcx
               	cmpl	$0x9, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzwq	0x6(%rdi), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x18(%rdi), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x3c(%rdi), %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1f0, %rsp            # imm = 0x1F0
               	leaq	<rip>, %rdi
               	leaq	-0x1e0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rdi), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rdi), %rax
               	movq	%rax, 0x18(%rdx)
               	movq	0x20(%rdi), %rax
               	movq	%rax, 0x20(%rdx)
               	movq	0x28(%rdi), %rax
               	movq	%rax, 0x28(%rdx)
               	movq	0x30(%rdi), %rax
               	movq	%rax, 0x30(%rdx)
               	movq	0x38(%rdi), %rax
               	movq	%rax, 0x38(%rdx)
               	movq	0x40(%rdi), %rax
               	movq	%rax, 0x40(%rdx)
               	movq	0x48(%rdi), %rax
               	movq	%rax, 0x48(%rdx)
               	movq	0x50(%rdi), %rax
               	movq	%rax, 0x50(%rdx)
               	movq	0x58(%rdi), %rax
               	movq	%rax, 0x58(%rdx)
               	movq	0x60(%rdi), %rax
               	movq	%rax, 0x60(%rdx)
               	movq	0x68(%rdi), %rax
               	movq	%rax, 0x68(%rdx)
               	movq	0x70(%rdi), %rax
               	movq	%rax, 0x70(%rdx)
               	movq	0x78(%rdi), %rax
               	movq	%rax, 0x78(%rdx)
               	movq	0x80(%rdi), %rax
               	movq	%rax, 0x80(%rdx)
               	movq	0x88(%rdi), %rax
               	movq	%rax, 0x88(%rdx)
               	movq	0x90(%rdi), %rax
               	movq	%rax, 0x90(%rdx)
               	movzbq	0x98(%rdi), %rax
               	movb	%al, 0x98(%rdx)
               	movzbq	0x99(%rdi), %rax
               	movb	%al, 0x99(%rdx)
               	movzbq	0x9a(%rdi), %rax
               	movb	%al, 0x9a(%rdx)
               	movzbq	0x9b(%rdi), %rax
               	movb	%al, 0x9b(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
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
               	movzwq	(%rdx), %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rdx), %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0xa(%rdx), %rax
               	leaq	-0x140(%rbp), %rcx
               	movw	%ax, 0xa(%rcx)
               	leaq	-0x1e0(%rbp), %rax
               	movslq	0x24(%rax), %rdx
               	movl	%edx, 0x24(%rcx)
               	movslq	0x2c(%rax), %rdx
               	movl	%edx, 0x2c(%rcx)
               	movslq	0x98(%rax), %rax
               	movl	%eax, 0x98(%rcx)
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
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x6c(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movzwq	0x8(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	0x98(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
