
fp_nan_unordered_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400b57 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movq	%r11, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r10
               	movq	%r10, -0x10(%rbp)
               	movabsq	$0x4014000000000000, %r9 # imm = 0x4014000000000000
               	movabsq	$0x3ff0000000000000, %r8 # imm = 0x3FF0000000000000
               	movq	%r8, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x20(%rbp)
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	0x400449 <.text+0x1c9>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	0x40048a <.text+0x20a>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x4004cf <.text+0x24f>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	xorq	%r8, %r8
               	movq	%rax, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400517 <.text+0x297>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40055c <.text+0x2dc>
               	movl	$0xa, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005a1 <.text+0x321>
               	movl	$0xb, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4005e2 <.text+0x362>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	xorq	%rax, %rax
               	movq	%r8, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400626 <.text+0x3a6>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400667 <.text+0x3e7>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x40069d <.text+0x41d>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4006de <.text+0x45e>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x400714 <.text+0x494>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400759 <.text+0x4d9>
               	movl	$0x18, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x40078f <.text+0x50f>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4007d4 <.text+0x554>
               	movl	$0x1a, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x40080a <.text+0x58a>
               	movl	$0x1b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40084b <.text+0x5cb>
               	movl	$0x1c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40088c <.text+0x60c>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x4008c2 <.text+0x642>
               	movl	$0x1e, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4018000000000000, %r8 # imm = 0x4018000000000000
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x40090d <.text+0x68d>
               	movl	$0x28, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	0x400954 <.text+0x6d4>
               	movl	$0x29, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x40098a <.text+0x70a>
               	movl	$0x2a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movabsq	$0x7e37e43c8800759c, %rax # imm = 0x7E37E43C8800759C
               	movq	%r8, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x4009ca <.text+0x74a>
               	movl	$0x2b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400a0b <.text+0x78b>
               	movl	$0x2c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
