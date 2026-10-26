
value_builtins.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x3, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	movabsq	$0x7fe1ccf385ebc8a0, %rax # imm = 0x7FE1CCF385EBC8A0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	leaq	<rip>, %rax # <addr>
               	movss	(%rax), %xmm0
               	movl	$0x7f61b1e6, %eax       # imm = 0x7F61B1E6
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	movsd	%xmm0, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movabsq	$0x7ff8000000000000, %r11 # imm = 0x7FF8000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movsd	(%rcx), %xmm0
               	movq	%rax, -0x20(%rbp)
               	movsd	%xmm0, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movabsq	$0x7ff8000000000010, %r11 # imm = 0x7FF8000000000010
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movss	(%rcx), %xmm0
               	movl	%eax, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %ecx
               	cmpl	$0x7fc00007, %ecx       # imm = 0x7FC00007
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movabsq	$0x7ff8000000000008, %rcx # imm = 0x7FF8000000000008
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movabsq	$0x7ff8000000000008, %r11 # imm = 0x7FF8000000000008
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	%eax, -0x18(%rbp)
               	movl	$0x7fc00001, -0x18(%rbp) # imm = 0x7FC00001
               	movl	-0x18(%rbp), %ecx
               	cmpl	$0x7fc00001, %ecx       # imm = 0x7FC00001
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0xfffffed4, -0x10(%rbp) # imm = 0xFFFFFED4
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rcx
               	subq	$0x30, %rcx
               	cmpq	$0xa, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	movl	-0x10(%rbp), %edx
               	imulq	%rdx, %rcx
               	movslq	-0x10(%rbp), %rdx
               	andq	$-0x80, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	movl	-0x10(%rbp), %edx
               	andq	$0x7f, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	-0x10(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, -0x10(%rbp)
               	movl	-0x10(%rbp), %ecx
               	cmpl	$0x12c, %ecx            # imm = 0x12C
               	jl	<addr>
               	cmpl	$0x9761, %eax           # imm = 0x9761
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
