
switch_jump_table_dense.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dense_signed>:
               	movslq	%edi, %rdi
               	leaq	-0x3(%rdi), %rax
               	cmpq	$0x11, %rax
               	jae	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rax,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	addb	%r8b, (%rax)
               	addb	%cl, (%rdx)
               	addb	%al, (%rax)
               	pushq	%rax
               	addb	%al, (%rax)
               	addb	%dl, (%rsi)
               	addb	%al, (%rax)
               	popq	%rsp
               	addb	%al, (%rax)
               	addb	%ah, (%rdx)
               	addb	%al, (%rax)
               	pushq	$0x6e000000             # imm = 0x6E000000
               	addb	%al, (%rax)
               	addb	%dh, (%rax,%rax)
               	addb	%bh, (%rdx)
               	addb	%al, (%rax)
               	addb	$0x0, (%rax)
               	addb	%al, -0x74000000(%rsi)
               	addb	%al, (%rax)
               	addb	%dl, -0x63000000(%rdi)
               	addb	%al, (%rax)
               	addb	%ah, -0x57000000(%rbx)
               	addb	%al, (%rax)
               	addb	%bh, 0x1(%rax)
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movl	$0xa, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	movl	$0xc, %eax
               	retq
               	movabsq	$-0x1, %rax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0xe, %eax
               	retq
               	movl	$0xf, %eax
               	retq
               	movl	$0x10, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<dense_negative_bias>:
               	leaq	0x6(%rdi), %rax
               	cmpq	$0x9, %rax
               	jae	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rax,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	andb	$0x0, %al
               	addb	%al, (%rax)
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	xorb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, %ss:(%rax)
               	addb	%bh, (%rax,%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%cl, (%rax)
               	addb	%al, (%rax)
               	addb	%r8b, (%rax)
               	addb	%dl, (%rax,%rax)
               	addb	%bh, 0x1(%rax)
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movabsq	$-0x1, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<dense_unsigned_high>:
               	movl	%edi, %eax
               	movl	$0xfffffff6, %r11d      # imm = 0xFFFFFFF6
               	subq	%r11, %rax
               	cmpq	$0xa, %rax
               	jae	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rax,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	subb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, %cs:(%rax)
               	addb	%dh, (%rax,%rax)
               	addb	%al, (%rax)
               	cmpb	(%rax), %al
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rsi)
               	addb	%al, (%rax)
               	addb	%r8b, (%rax)
               	addb	%dl, (%rdx)
               	addb	%al, (%rax)
               	popq	%rax
               	addb	%al, (%rax)
               	addb	%bl, (%rsi)
               	addb	%al, (%rax)
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movl	$0xa, %eax
               	retq
               	movabsq	$-0x1, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x3, %ebx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0xf, %rax
               	jge	<addr>
               	leaq	-0x2(%rbx), %rax
               	movslq	%eax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%r12d, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x3(%rbx), %rax
               	movslq	%eax, %r12
               	jmp	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x13, %rax
               	jle	<addr>
               	movl	$0xf, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x6, %rbx
               	jmp	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x7(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	movabsq	$-0x7, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x100000000, %rdi      # imm = 0x100000000
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x100000000, %rdi     # imm = 0xFFFFFFFF00000000
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movl	%ebx, %eax
               	movl	$0xfffffff6, %r11d      # imm = 0xFFFFFFF6
               	addq	%r11, %rax
               	movl	%eax, %edi
               	callq	<addr>
               	movl	%ebx, %ecx
               	incq	%rcx
               	movl	%ecx, %ecx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	cmpq	$0xa, %rax
               	jb	<addr>
               	movl	$0xfffffff5, %edi       # imm = 0xFFFFFFF5
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
