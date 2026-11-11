
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
               	subq	$0x30, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx,%rax,8), %rdx
               	movq	%rdx, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	fldt	-0x30(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x8(%rbp), %rdx
               	movq	-0x10(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jb	<addr>
               	movabsq	$0x7ff8000000000000, %rax # imm = 0x7FF8000000000000
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	fldt	-0x30(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	andq	%rax, %rcx
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8340, %rax           # imm = 0x8340
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	movzbq	-0x29(%rbp), %rax
               	movzbq	-0x28(%rbp), %rcx
               	movzbq	-0x27(%rbp), %rdx
               	cmpl	$0x80, %eax
               	jne	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	cmpl	$0x3f, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	addq	$0xa, %rax
               	leave
               	retq
