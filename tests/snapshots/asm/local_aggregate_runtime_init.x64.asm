
local_aggregate_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	movl	$0x68, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x4(%rdx)
               	movl	$0x6f, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x5(%rdx)
               	movl	$0x6c, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x6(%rdx)
               	movl	$0x61, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x7(%rdx)
               	xorq	%rcx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x9(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xa(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xb(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xd(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movzbq	0x4(%rcx), %rcx
               	xorq	$0x68, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %esi
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movzbq	0x5(%rcx), %rcx
               	xorq	$0x6f, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	movl	$0x1, %edx
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movzbq	0x6(%rcx), %rcx
               	xorq	$0x6c, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movzbq	0x7(%rcx), %rcx
               	xorq	$0x61, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movzbq	0x8(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movzbq	0xd(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movslq	(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movl	$0x5, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x6f, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rax
               	xorq	$0x6b, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
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
               	addb	%al, 0x41(%rdx)
