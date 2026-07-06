
ternary_middle_comma.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movl	$0x2a, %eax
               	movl	%eax, %ecx
               	cmpq	$0x80, %rcx
               	jae	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx)
               	movl	$0x1, %edx
               	jmp	<addr>
               	movl	$0x63, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%edx, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rcx)
               	popq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x80, %rcx
               	jae	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx)
               	movl	$0x1, %edx
               	jmp	<addr>
               	movl	$0x63, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%edx, %rsi
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rcx)
               	popq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x80, %rcx
               	jae	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx)
               	movl	$0x1, %edx
               	jmp	<addr>
               	movl	$0x63, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%edx, %rsi
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	jle	<addr>
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rdx, %rsi
               	movq	%rdx, %rdi
               	movslq	%ecx, %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r9d
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%edi, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movl	$0x1, %r8d
               	testq	%r9, %r9
               	jne	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rcx
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %r8
               	movq	%rdi, %rdx
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movl	$0xc8, %eax
               	movl	%eax, %ecx
               	cmpq	$0x80, %rcx
               	jae	<addr>
               	leaq	-0x60(%rbp), %rcx
               	andq	$0xff, %rax
               	movb	%al, (%rcx)
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x63, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x63, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ecx, %rsi
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
