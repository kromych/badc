
libc_fp_return_value.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %ebx
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movabsq	$0x400599999999999a, %rdi # imm = 0x400599999999999A
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movsd	-0x18(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movabsq	$0x4002666666666666, %rdi # imm = 0x4002666666666666
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movabsq	$0x400c000000000000, %r12 # imm = 0x400C000000000000
               	movq	%r12, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp,%riz)
               	movsd	-0x28(%rbp,%riz), %xmm0
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movabsq	$0x401c000000000000, %rdi # imm = 0x401C000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x30(%rbp,%riz)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xb, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
