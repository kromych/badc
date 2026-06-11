
libc_math_round.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x3b0, %esi            # imm = 0x3B0
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x400c000000000000, %rdi # imm = 0x400C000000000000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4003333333333333, %rdi # imm = 0x4003333333333333
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movabsq	$0xe8d4a51000, %rax     # imm = 0xE8D4A51000
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0xe8d4a51001, %r13     # imm = 0xE8D4A51001
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
