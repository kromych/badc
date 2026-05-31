
call_arg_int_to_double_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40044d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfdf1(%rip)           # 0x410108
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfdde(%rip), %r9       # 0x410118
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40038b <.text+0x8b>
               	leaq	0xfdba(%rip), %rdi      # 0x410118
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
               	leaq	0xfd97(%rip), %rdi      # 0x410130
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd85(%rip), %rsi      # 0x410136
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd74(%rip), %r9       # 0x41013d
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
               	callq	0x4009e7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400419 <.text+0x119>
               	leaq	0xfd17(%rip), %r14      # 0x410118
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400419 <.text+0x119>
               	leaq	0xfcf8(%rip), %r12      # 0x410118
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movl	$0x1, %r9d
               	cvtsi2sd	%r9, %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x58(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4004f0 <.text+0x1f0>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movl	$0x2, %eax
               	cvtsi2sd	%rax, %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movq	%r12, %xmm0
               	movsd	0x50(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400584 <.text+0x284>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movl	$0x3, %r12d
               	cvtsi2sd	%r12, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movq	%r14, %xmm0
               	movsd	0x48(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4020000000000000, %r14 # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400619 <.text+0x319>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movl	$0x4, %r14d
               	cvtsi2sd	%r14, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x40(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4030000000000000, %rbx # imm = 0x4030000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4006ad <.text+0x3ad>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r14d
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movslq	%r14d, %rax
               	cvtsi2sd	%rax, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movq	%r12, %xmm0
               	movsd	0x38(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400745 <.text+0x445>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r14d
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movslq	%r14d, %rax
               	cvtsi2sd	%rax, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x30(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4020000000000000, %rbx # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4007dc <.text+0x4dc>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movl	$0x2, %ebx
               	cvtsi2sd	%rbx, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movq	%r12, %xmm0
               	movsd	0x28(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ed <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400870 <.text+0x570>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf8f1(%rip), %r14      # 0x410168
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x4009f3 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
