
call_arg_int_to_double_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movl	$0x1, %r9d
               	cvtsi2sd	%r9, %xmm7
               	movq	%rbx, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movl	$0x2, %ebx
               	cvtsi2sd	%rbx, %xmm7
               	movq	%rdi, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movl	$0x3, %edi
               	cvtsi2sd	%rdi, %xmm7
               	movq	%rax, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rdi
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movl	$0x4, %eax
               	cvtsi2sd	%rax, %xmm7
               	movq	%rdi, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4030000000000000, %rdi # imm = 0x4030000000000000
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	cvtsi2sd	%rax, %xmm7
               	movq	%rdi, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	cvtsi2sd	%rax, %xmm7
               	movq	%rdi, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x4020000000000000, %rdi # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movl	$0x2, %edi
               	cvtsi2sd	%rdi, %xmm7
               	movq	%rax, %xmm0
               	movapd	%xmm7, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rdi
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
