
negative_float_in_array_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400787 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0xfd69(%rip), %r11      # 0x410148
               	movq	(%r11), %r9
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r9, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400429 <.text+0x1a9>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd18(%rip), %r8       # 0x410148
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r8, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40049c <.text+0x21c>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfca5(%rip), %rax      # 0x410148
               	movq	%rax, %r8
               	addq	$0x10, %r8
               	movq	(%r8), %rax
               	movabsq	$0x421e449a94000000, %r8 # imm = 0x421E449A94000000
               	movq	%r8, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40050b <.text+0x28b>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc36(%rip), %r8       # 0x410148
               	movq	(%r8), %rax
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rdi
               	movq	%rax, %xmm7
               	movq	%rdi, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%r8, %rdi
               	addq	$0x10, %rdi
               	movq	(%rdi), %r8
               	movapd	%xmm7, %xmm6
               	movq	%r8, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r8
               	movabsq	$0x421e449a94000000, %rdi # imm = 0x421E449A94000000
               	movq	%rdi, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movabsq	$0x3fe0000000000000, %rdi # imm = 0x3FE0000000000000
               	movapd	%xmm6, %xmm7
               	movq	%rdi, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%r8, %xmm14
               	ucomisd	%xmm7, %xmm14
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x10(%rbp)
               	cmpq	$0x0, %rdi
               	jne	0x40061c <.text+0x39c>
               	movq	-0x8(%rbp), %r8
               	movabsq	$0x421e449a94000000, %rdi # imm = 0x421E449A94000000
               	movq	%rdi, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movapd	%xmm7, %xmm6
               	movq	%rdi, %xmm15
               	subsd	%xmm15, %xmm6
               	movq	%r8, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setb	%dil
               	movzbq	%dil, %rdi
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdi
               	movq	%rdi, -0x10(%rbp)
               	jmp	0x40061c <.text+0x39c>
               	movq	-0x10(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x40063b <.text+0x3bb>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
