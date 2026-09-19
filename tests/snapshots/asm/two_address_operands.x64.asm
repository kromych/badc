
two_address_operands.x64:	file format elf64-x86-64

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

<rsub>:
               	leaq	(%rdi,%rdi,2), %rcx
               	movq	%rsi, %rax
               	subq	%rcx, %rax
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<rsub_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %rdi
               	callq	*%rsi
               	negq	%rax
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<fdiv_rev>:
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm1, %xmm0
               	divsd	%xmm2, %xmm0
               	retq

<fsub_rev>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	vfnmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = -(xmm14 * xmm15) + xmm0
               	retq

<fsub_rev_f>:
               	movapd	%xmm0, %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	vfnmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = -(xmm14 * xmm15) + xmm0
               	retq

<ones>:
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rdi, %r8
               	movq	%rax, %rcx
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	andq	$0x1, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<past_fourth>:
               	movq	%rcx, %rax
               	movq	%rsi, %rcx
               	shlq	%cl, %rdi
               	addq	%rdi, %rax
               	addq	%rdx, %rax
               	retq

<all_live>:
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	sarq	%cl, %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	retq

<carried>:
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	leaq	(%rax,%r9), %rdx
               	movq	%rsi, %r11
               	movq	%r8, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	addq	%rcx, %rax
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<rotr>:
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	movl	$0x40, %ecx
               	subq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	%rdi, %rdx
               	shlq	%cl, %rdx
               	orq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rdi
               	addq	$0x18, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rcx
               	movq	(%rcx), %rdi
               	addq	$0x28, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	movabsq	$-0x7ffffffffffffffb, %r11 # imm = 0x8000000000000005
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rdi
               	leaq	-<rip>, %rsi      # <addr>
               	callq	<addr>
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rdi
               	leaq	-<rip>, %rsi      # <addr>
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	addq	$0x8, %rax
               	movsd	(%rax,%riz), %xmm1
               	callq	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	addq	$0x18, %rax
               	movsd	(%rax,%riz), %xmm1
               	callq	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x18(%rax), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	addq	$0x20, %rax
               	movsd	(%rax,%riz), %xmm1
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x28(%rax), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	addq	$0x30, %rax
               	movsd	(%rax,%riz), %xmm1
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x18(%rax), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	addq	$0x20, %rax
               	movsd	(%rax,%riz), %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	callq	<addr>
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0xf0f0f0f0f0f0f10, %rdi # imm = 0xF0F0F0F0F0F0F0F0
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x20, %rax
               	jne	<addr>
               	movl	$0xff, %edi
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	leaq	0x8(%rax), %rcx
               	movq	(%rcx), %rsi
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x18, %rax
               	movq	(%rax), %rcx
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rcx
               	movq	(%rcx), %rdi
               	movq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x15183, %rax          # imm = 0x15183
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x28(%rax), %rcx
               	movq	(%rcx), %rdi
               	leaq	0x30(%rax), %rcx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdx
               	addq	$0x38, %rax
               	movq	(%rax), %rcx
               	callq	<addr>
               	cmpq	$0x71, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	leaq	<rip>, %rax
               	addq	$0x48, %rax
               	movq	(%rax), %rax
               	movl	%eax, %esi
               	callq	<addr>
               	movabsq	$-0x10fedcba98765433, %r11 # imm = 0xEF0123456789ABCD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	addq	$0x50, %rax
               	movq	(%rax), %rax
               	movl	%eax, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	addq	$0x38, %rax
               	movq	(%rax), %rax
               	movl	%eax, %esi
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
