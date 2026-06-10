
designator_override_and_braced_string.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<take>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rdx, %rdx
               	movzbq	(%rdi), %rax
               	xorq	$0x61, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movzbq	0x1(%rdi), %rax
               	xorq	$0x62, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movzbq	0x2(%rdi), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movzbq	0x3(%rdi), %rax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpq	$0x2, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xc(%rbx), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r12d
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movzbq	0xd(%rbx), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movzbq	0xe(%rbx), %rax
               	cmpq	$0x0, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	movzbq	0x4(%rcx), %r11
               	movb	%r11b, 0x4(%rax)
               	movzbq	0x5(%rcx), %r11
               	movb	%r11b, 0x5(%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x77, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x5(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	movzbq	0x4(%rcx), %r11
               	movb	%r11b, 0x4(%rax)
               	movzbq	0x5(%rcx), %r11
               	movb	%r11b, 0x5(%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
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
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
