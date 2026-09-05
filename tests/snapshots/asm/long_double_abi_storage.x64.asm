
long_double_abi_storage.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x8, %r12d
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x28(%rbp,%riz)
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	cmpl	$0xc, %eax
               	jb	<addr>
               	movabsq	$0x7ff8000000000000, %rax # imm = 0x7FF8000000000000
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x8, %ebx
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x28(%rbp,%riz)
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	andq	%r11, %rax
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8340(%rax), %rcx
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rcx)
               	fldt	(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x7(%rax), %rcx
               	xorq	$0x80, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	xorq	$0xff, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x9(%rax), %rax
               	xorq	$0x3f, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	%ebx, %eax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
