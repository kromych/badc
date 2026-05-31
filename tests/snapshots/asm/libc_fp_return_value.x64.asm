
libc_fp_return_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40050d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfd49(%rip)           # 0x410120
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd36(%rip), %r9       # 0x410130
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40044b <.text+0x8b>
               	leaq	0xfd12(%rip), %rdi      # 0x410130
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
               	leaq	0xfcef(%rip), %rdi      # 0x410148
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfcdd(%rip), %rsi      # 0x41014e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfccc(%rip), %r9       # 0x410155
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
               	callq	0x4008c7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4004d9 <.text+0x119>
               	leaq	0xfc6f(%rip), %r14      # 0x410130
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4004d9 <.text+0x119>
               	leaq	0xfc50(%rip), %r12      # 0x410130
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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x1, %r11d
               	movl	%r11d, -0x8(%rbp)
               	movabsq	$0x4010000000000000, %rbx # imm = 0x4010000000000000
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008cd <sqrt>
               	movq	%xmm0, %rax
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40058f <.text+0x1cf>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x40058f <.text+0x1cf>
               	movabsq	$0x400599999999999a, %r12 # imm = 0x400599999999999A
               	movq	%r12, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008d3 <floor>
               	movq	%xmm0, %rax
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4005ef <.text+0x22f>
               	xorq	%r12, %r12
               	movl	%r12d, -0x8(%rbp)
               	jmp	0x4005ef <.text+0x22f>
               	movabsq	$0x4002666666666666, %rbx # imm = 0x4002666666666666
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008d9 <ceil>
               	movq	%xmm0, %rax
               	movabsq	$0x4008000000000000, %rbx # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40064e <.text+0x28e>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x40064e <.text+0x28e>
               	movabsq	$0x400c000000000000, %r12 # imm = 0x400C000000000000
               	movq	%r12, %xmm14
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	xorl	%eax, %eax
               	callq	0x4008df <fabs>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4006ca <.text+0x30a>
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x4006ca <.text+0x30a>
               	movabsq	$0x401c000000000000, %rbx # imm = 0x401C000000000000
               	movabsq	$0x4010000000000000, %r14 # imm = 0x4010000000000000
               	movq	%rbx, %xmm0
               	movq	%r14, %xmm1
               	xorl	%eax, %eax
               	callq	0x4008e5 <fmod>
               	movq	%xmm0, %rax
               	movabsq	$0x4008000000000000, %r14 # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400739 <.text+0x379>
               	xorq	%r14, %r14
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x400739 <.text+0x379>
               	movslq	-0x8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x400758 <.text+0x398>
               	movl	$0xb, %ebx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x400764 <.text+0x3a4>
               	xorq	%rbx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x400764 <.text+0x3a4>
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
