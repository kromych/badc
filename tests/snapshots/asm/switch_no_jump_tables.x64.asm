
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

<fallthrough_sum>:
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	cmpl	$0x4, %edi
               	jl	<addr>
               	cmpl	$0x6, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	je	<addr>
               	movabsq	$-0x1, %rax
               	movslq	%eax, %rax
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
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0xf, %eax
               	je	<addr>
               	cmpl	$0xf, %eax
               	jge	<addr>
               	leaq	-0x2(%rax), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0xb, %rax
               	jl	<addr>
               	cmpq	$0x10, %rax
               	jl	<addr>
               	cmpl	$0x12, %eax
               	jl	<addr>
               	cmpq	$0x13, %rax
               	jl	<addr>
               	movl	$0x10, %ecx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movl	$0xf, %ecx
               	jmp	<addr>
               	cmpq	$0x11, %rax
               	jl	<addr>
               	movl	$0xe, %ecx
               	jmp	<addr>
               	movl	$0xd, %ecx
               	jmp	<addr>
               	cmpq	$0xd, %rax
               	jl	<addr>
               	cmpl	$0xe, %eax
               	jl	<addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	jmp	<addr>
               	movl	$0xc, %ecx
               	jmp	<addr>
               	movl	$0xb, %ecx
               	jmp	<addr>
               	cmpl	$0xc, %eax
               	jl	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	jmp	<addr>
               	cmpl	$0x7, %eax
               	jl	<addr>
               	cmpq	$0x9, %rax
               	jl	<addr>
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0x7, %ecx
               	jmp	<addr>
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	$0x6, %ecx
               	jmp	<addr>
               	movl	$0x5, %ecx
               	jmp	<addr>
               	cmpq	$0x5, %rax
               	jl	<addr>
               	cmpl	$0x6, %eax
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	leaq	-0x3(%rax), %rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x13, %eax
               	jle	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movabsq	$-0x6, %rax
               	jmp	<addr>
               	cmpq	$-0x2, %rax
               	jl	<addr>
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x1, %rax
               	jl	<addr>
               	cmpq	$0x2, %rax
               	jl	<addr>
               	movl	$0x9, %ecx
               	leaq	0x7(%rax), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0x7, %ecx
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	movl	$0x6, %ecx
               	jmp	<addr>
               	movl	$0x5, %ecx
               	jmp	<addr>
               	cmpq	$-0x4, %rax
               	jl	<addr>
               	cmpq	$-0x3, %rax
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpq	$-0x5, %rax
               	jl	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	cmpq	$-0x6, %rax
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	incq	%rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movl	$0xfffffff6, %edx       # imm = 0xFFFFFFF6
               	movl	$0xfffffff7, %edi       # imm = 0xFFFFFFF7
               	movl	$0xfffffff8, %r8d       # imm = 0xFFFFFFF8
               	movl	$0xfffffff9, %r9d       # imm = 0xFFFFFFF9
               	movl	$0xfffffffa, %ebx       # imm = 0xFFFFFFFA
               	movl	$0xfffffffb, %r12d      # imm = 0xFFFFFFFB
               	jmp	<addr>
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%eax, %eax
               	cmpq	%r12, %rax
               	jb	<addr>
               	movl	$0xfffffffd, %r11d      # imm = 0xFFFFFFFD
               	movq	%rax, %rsi
               	cmpl	%r11d, %eax
               	jb	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0xa, %eax
               	movl	%ecx, %esi
               	incq	%rsi
               	movl	%esi, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	$0xfffffffc, %r11d      # imm = 0xFFFFFFFC
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	cmpq	%r8, %rax
               	jb	<addr>
               	cmpq	%r9, %rax
               	jb	<addr>
               	cmpq	%rbx, %rax
               	jb	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	%rdi, %rax
               	jb	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	cmpl	%edx, %eax
               	je	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	%ecx, %eax
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpq	$0xa, %rax
               	jb	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movl	$0x100, %ecx            # imm = 0x100
               	movl	$0x1, %eax
               	movslq	%ebx, %rdx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%r12, %rax
               	jne	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpq	$0x7, %rbx
               	jle	<addr>
               	movl	$0x8, %edi
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
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
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
