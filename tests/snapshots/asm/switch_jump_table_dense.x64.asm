
switch_jump_table_dense.x64:	file format elf64-x86-64

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

<dense_signed>:
               	movslq	%edi, %rdi
               	leaq	-0x3(%rdi), %rax
               	cmpq	$0x11, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
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

<dense_negative_bias>:
               	leaq	0x6(%rdi), %rax
               	cmpq	$0x9, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
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
               	movabsq	$-0x1, %rax
               	retq

<dense_unsigned_high>:
               	movl	%edi, %eax
               	movl	$0xfffffff6, %r11d      # imm = 0xFFFFFFF6
               	subq	%r11, %rax
               	cmpq	$0xa, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x3, %ebx
               	jmp	<addr>
               	cmpl	$0xf, %ebx
               	je	<addr>
               	cmpl	$0xf, %ebx
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
               	cmpl	$0x13, %ebx
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
               	movabsq	$-0x6, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rdi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movabsq	$-0x4, %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movabsq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movabsq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
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
               	movl	$0xfffffff6, %edi       # imm = 0xFFFFFFF6
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xfffffff7, %edi       # imm = 0xFFFFFFF7
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movl	$0xfffffff8, %edi       # imm = 0xFFFFFFF8
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0xfffffff9, %edi       # imm = 0xFFFFFFF9
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	$0xfffffffa, %edi       # imm = 0xFFFFFFFA
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0xfffffffb, %edi       # imm = 0xFFFFFFFB
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movl	$0xfffffffc, %edi       # imm = 0xFFFFFFFC
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0xfffffffd, %edi       # imm = 0xFFFFFFFD
               	callq	<addr>
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movl	$0xfffffffe, %edi       # imm = 0xFFFFFFFE
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
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
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
