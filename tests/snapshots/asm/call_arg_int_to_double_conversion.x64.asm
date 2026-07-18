
call_arg_int_to_double_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rbx, %xmm0
               	movq	%rsi, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rdi, %xmm0
               	movq	%rdi, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rsi # imm = 0x4008000000000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rdi, %xmm0
               	movq	%rdi, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
