
value_builtins.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<main>:
               	subq	$0x28, %rsp
               	movl	$0x3, 0x18(%rsp)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	0x18(%rsp), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1
               	comiss	%xmm1, %xmm0
               	jbe	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rax
               	movabsq	$0x7ff8000000000000, %r11 # imm = 0x7FF8000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rax
               	movabsq	$0x7ff8000000000010, %r11 # imm = 0x7FF8000000000010
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	cmpl	$0x7fc00007, %eax       # imm = 0x7FC00007
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7fc00001, 0x8(%rsp)  # imm = 0x7FC00001
               	movl	0x8(%rsp), %eax
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	$0xfffffed4, 0x10(%rsp) # imm = 0xFFFFFED4
               	jmp	<addr>
               	movslq	0x10(%rsp), %rcx
               	subq	$0x30, %rcx
               	cmpq	$0xa, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	movl	0x10(%rsp), %edx
               	imulq	%rdx, %rcx
               	movslq	0x10(%rsp), %rdx
               	andq	$-0x80, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	movl	0x10(%rsp), %edx
               	andq	$0x7f, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	incq	%rcx
               	movl	%ecx, 0x10(%rsp)
               	movl	0x10(%rsp), %ecx
               	cmpl	$0x12c, %ecx            # imm = 0x12C
               	jl	<addr>
               	cmpl	$0x9761, %eax           # imm = 0x9761
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
