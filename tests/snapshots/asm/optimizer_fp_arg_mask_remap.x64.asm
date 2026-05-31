
optimizer_fp_arg_mask_remap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4004d0 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfd81(%rip)           # 0x410118
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd6e(%rip), %r9       # 0x410128
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40040b <.text+0x8b>
               	leaq	0xfd4a(%rip), %rdi      # 0x410128
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
               	leaq	0xfd27(%rip), %rdi      # 0x410140
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd15(%rip), %rsi      # 0x410146
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd04(%rip), %r9       # 0x41014d
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
               	callq	0x4008f7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40049c <.text+0x11c>
               	leaq	0xfca4(%rip), %r14      # 0x410128
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40049c <.text+0x11c>
               	leaq	0xfc85(%rip), %r12      # 0x410128
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$0x3fe0000000000000, %rbx # imm = 0x3FE0000000000000
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008fd <sin>
               	movq	%xmm0, %r12
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	0x400903 <cos>
               	movq	%xmm0, %r14
               	movabsq	$0x4010000000000000, %r15 # imm = 0x4010000000000000
               	movq	%r15, %xmm0
               	xorl	%eax, %eax
               	callq	0x400909 <sqrt>
               	movq	%xmm0, %rbx
               	xorq	%r15, %r15
               	movq	%r15, %xmm0
               	xorl	%eax, %eax
               	callq	0x40090f <exp>
               	movq	%xmm0, %rsi
               	movabsq	$0x3fdea7ef9db22d0e, %r15 # imm = 0x3FDEA7EF9DB22D0E
               	movq	%r12, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%dl
               	movzbq	%dl, %rdx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdx
               	movq	%rdx, -0x38(%rbp)
               	cmpq	$0x0, %rdx
               	jne	0x4005b0 <.text+0x230>
               	movabsq	$0x3fdeb851eb851eb8, %r15 # imm = 0x3FDEB851EB851EB8
               	movq	%r12, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x38(%rbp)
               	jmp	0x4005b0 <.text+0x230>
               	movq	-0x38(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	0x4005e9 <.text+0x269>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fec10624dd2f1aa, %rdx # imm = 0x3FEC10624DD2F1AA
               	movq	%r14, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r15b
               	movzbq	%r15b, %r15
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r15
               	movq	%r15, -0x40(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x400650 <.text+0x2d0>
               	movabsq	$0x3fec189374bc6a7f, %rdx # imm = 0x3FEC189374BC6A7F
               	movq	%r14, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x40(%rbp)
               	jmp	0x400650 <.text+0x2d0>
               	movq	-0x40(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400688 <.text+0x308>
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r15 # imm = 0x4000000000000000
               	movq	%rbx, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	je	0x4006e9 <.text+0x369>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3feff7ced916872b, %rdx # imm = 0x3FEFF7CED916872B
               	movq	%rsi, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r15b
               	movzbq	%r15b, %r15
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r15
               	movq	%r15, -0x48(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x400750 <.text+0x3d0>
               	movabsq	$0x3ff004189374bc6a, %rdx # imm = 0x3FF004189374BC6A
               	movq	%rsi, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x400750 <.text+0x3d0>
               	movq	-0x48(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400788 <.text+0x408>
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x13, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
