
call_arg_int_to_double_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400436 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400385 <.text+0x85>
               	leaq	0xfdbd(%rip), %r9       # 0x410118
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
               	leaq	0xfd9d(%rip), %rdi      # 0x410130
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfd8e(%rip), %rdi      # 0x410136
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfd80(%rip), %rdi      # 0x41013d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4009a7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400407 <.text+0x107>
               	leaq	0xfd26(%rip), %r14      # 0x410118
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400407 <.text+0x107>
               	leaq	0xfd0a(%rip), %r12      # 0x410118
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movl	$0x1, %r9d
               	cvtsi2sd	%r9, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x48(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
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
               	je	0x4004cf <.text+0x1cf>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movl	$0x2, %ebx
               	cvtsi2sd	%rbx, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movq	%r12, %xmm0
               	movsd	0x40(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40055e <.text+0x25e>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movl	$0x3, %r12d
               	cvtsi2sd	%r12, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x38(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4020000000000000, %rbx # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005ed <.text+0x2ed>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movl	$0x4, %ebx
               	cvtsi2sd	%rbx, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movq	%r12, %xmm0
               	movsd	0x30(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4030000000000000, %r12 # imm = 0x4030000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40067c <.text+0x37c>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movslq	%eax, %rax
               	cvtsi2sd	%rax, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x28(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %rbx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40070d <.text+0x40d>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movslq	%eax, %rax
               	cvtsi2sd	%rax, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movq	%r12, %xmm0
               	movsd	0x20(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4020000000000000, %r12 # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40079f <.text+0x49f>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movl	$0x2, %r12d
               	cvtsi2sd	%r12, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movq	%rbx, %xmm0
               	movsd	0x18(%rsp), %xmm1
               	xorl	%eax, %eax
               	callq	0x4009ad <pow>
               	movq	%xmm0, %rax
               	movabsq	$0x4010000000000000, %rbx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40082e <.text+0x52e>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf933(%rip), %r12      # 0x410168
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4009b3 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
