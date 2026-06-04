
signed_cast_extends.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movl	$0xff, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %eax       # imm = 0x1234ABFF
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5678, %rax           # imm = 0x5678
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %eax       # imm = 0x1234FFFF
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2a, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movl	$0xff, %ecx
               	movb	%cl, (%rax)
               	leaq	-0xb8(%rbp), %rax
               	addq	$0x1, %rax
               	movl	$0x42, %ecx
               	movb	%cl, (%rax)
               	leaq	-0xb8(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0x10, %ecx
               	movb	%cl, (%rax)
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	shlq	$0x8, %rax
               	movslq	%eax, %rax
               	leaq	-0xb8(%rbp), %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$-0xbe, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
