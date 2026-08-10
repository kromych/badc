
signed_cast_extends.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rtu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0xff, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	movl	%eax, %eax
               	movsbq	%al, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	movl	%eax, %eax
               	movsbq	%al, %rax
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %edi       # imm = 0x1234ABFF
               	callq	<addr>
               	movl	%eax, %eax
               	movsbq	%al, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	movl	%eax, %eax
               	movswq	%ax, %rax
               	cmpq	$0x5678, %rax           # imm = 0x5678
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %edi       # imm = 0x1234FFFF
               	callq	<addr>
               	movl	%eax, %eax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffd6, %edi       # imm = 0xFFFFFFD6
               	callq	<addr>
               	movsbq	%al, %rax
               	cmpq	$-0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	andq	$0xff, %rbx
               	movl	$0x42, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	andq	$0xff, %r12
               	movl	$0x10, %edi
               	callq	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	shlq	$0x8, %rax
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$-0xbe, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
