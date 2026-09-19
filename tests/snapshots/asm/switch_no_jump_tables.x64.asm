
switch_no_jump_tables.x64:	file format elf64-x86-64

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
               	cmpl	$0xb, %edi
               	jl	<addr>
               	cmpl	$0x10, %edi
               	jl	<addr>
               	cmpl	$0x12, %edi
               	jl	<addr>
               	cmpl	$0x13, %edi
               	jl	<addr>
               	cmpl	$0x13, %edi
               	je	<addr>
               	movq	$-0x1, %rax
               	retq
               	movl	$0x10, %eax
               	retq
               	movl	$0xf, %eax
               	retq
               	cmpl	$0x11, %edi
               	jl	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	cmpl	$0xd, %edi
               	jl	<addr>
               	cmpl	$0xe, %edi
               	jl	<addr>
               	cmpl	$0xe, %edi
               	jne	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	cmpl	$0xc, %edi
               	jl	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	cmpl	$0x7, %edi
               	jl	<addr>
               	cmpl	$0x9, %edi
               	jl	<addr>
               	cmpl	$0xa, %edi
               	jl	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	cmpl	$0x8, %edi
               	jl	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x5, %edi
               	jl	<addr>
               	cmpl	$0x6, %edi
               	jl	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x4, %edi
               	jl	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x3, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<fallthrough_sum>:
               	xorl	%eax, %eax
               	cmpl	$0x4, %edi
               	jl	<addr>
               	cmpl	$0x6, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	je	<addr>
               	movq	$-0x1, %rax
               	retq
               	addq	$0x80, %rax
               	jmp	<addr>
               	addq	$0x40, %rax
               	jmp	<addr>
               	cmpl	$0x5, %edi
               	jl	<addr>
               	addq	$0x20, %rax
               	jmp	<addr>
               	addq	$0x10, %rax
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x3, %edi
               	jl	<addr>
               	addq	$0x8, %rax
               	jmp	<addr>
               	addq	$0x4, %rax
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jl	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x3, %ebx
               	cmpl	$0x13, %ebx
               	jg	<addr>
               	cmpl	$0xf, %ebx
               	je	<addr>
               	cmpl	$0xf, %ebx
               	jge	<addr>
               	leaq	-0x2(%rbx), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%r12, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x3(%rbx), %r12
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x13, %ebx
               	jle	<addr>
               	movl	$0xf, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0xff, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xfe, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0xfc, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0xf8, %rax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0xf0, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0xe0, %rax
               	jne	<addr>
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpq	$0xc0, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x80, %rax
               	jne	<addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
