
switch_binary_search.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify_signed>:
               	movslq	%edi, %rdi
               	cmpq	$0x1, %rdi
               	jl	<addr>
               	cmpq	$0x2a, %rdi
               	jl	<addr>
               	cmpq	$0x3e8, %rdi            # imm = 0x3E8
               	jl	<addr>
               	cmpq	$0x3e8, %rdi            # imm = 0x3E8
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x7, %eax
               	retq
               	cmpq	$0x2a, %rdi
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpq	$0x7, %rdi
               	jl	<addr>
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$-0x3, %rdi
               	jl	<addr>
               	testq	%rdi, %rdi
               	jl	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$-0x3, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$-0x64, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<classify_unsigned>:
               	movl	%edi, %eax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jb	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x5, %rax
               	jb	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$-0x64, %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rdi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %edi
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e7, %edi            # imm = 0x3E7
               	movq	(%rbx), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
