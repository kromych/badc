
ftw_walk.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<visit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edx, %rdx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x180, %rsp            # imm = 0x180
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movzbq	0x10(%rcx), %r11
               	movb	%r11b, 0x10(%rax)
               	movzbq	0x11(%rcx), %r11
               	movb	%r11b, 0x11(%rax)
               	movzbq	0x12(%rcx), %r11
               	movb	%r11b, 0x12(%rax)
               	movzbq	0x13(%rcx), %r11
               	movb	%r11b, 0x13(%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x18(%rbp), %rcx
               	movslq	%ebx, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x118(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	-<rip>, %rsi      # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
