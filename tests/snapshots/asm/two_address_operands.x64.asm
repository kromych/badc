
two_address_operands.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %rdi
               	callq	*%rsi
               	negq	%rax
               	addq	%rbx, %rax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

<fdiv_rev>:
               	vmulsd	<rip>, %xmm0, %xmm2
               	vdivsd	%xmm2, %xmm1, %xmm0
               	retq

<fsub_rev>:
               	vmulsd	%xmm0, %xmm0, %xmm2
               	vsubsd	%xmm2, %xmm1, %xmm0
               	retq

<fsub_rev_f>:
               	vmulss	%xmm0, %xmm0, %xmm2
               	vsubss	%xmm2, %xmm1, %xmm0
               	retq

<ones>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	shrxq	%rax, %rdi, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<past_fourth>:
               	shlxq	%rsi, %rdi, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	retq

<all_live>:
               	sarxq	%rsi, %rdi, %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	retq

<carried>:
               	xorl	%eax, %eax
               	shlxq	%rdx, %rsi, %rsi
               	movq	%rax, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	leaq	(%rax,%rcx), %rdx
               	addq	%rsi, %rax
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<rotr>:
               	movq	%rsi, %rax
               	andq	$0x3f, %rax
               	shrxq	%rax, %rdi, %rax
               	movl	$0x40, %ecx
               	subq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	shlxq	%rcx, %rdi, %rcx
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$-0x7ffffffffffffffb, %r11 # imm = 0x8000000000000005
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	cvtsd2ss	%xmm0, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	cvtsd2ss	%xmm1, %xmm1
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movabsq	$-0xf0f0f0f0f0f0f10, %rdi # imm = 0xF0F0F0F0F0F0F0F0
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x20, %rax
               	jne	<addr>
               	movl	$0xff, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	xorl	%edi, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x15183, %rax          # imm = 0x15183
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	callq	<addr>
               	cmpq	$0x71, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r11
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$-0x10fedcba98765433, %r11 # imm = 0xEF0123456789ABCD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
