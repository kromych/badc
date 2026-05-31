
local_init_int_to_float.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
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
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
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
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm7
               	leaq	-0x10(%rbp), %r8
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4044f33333333333, %r8 # imm = 0x4044F33333333333
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	movq	%r9, -0x78(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x40450ccccccccccd, %r9 # imm = 0x40450CCCCCCCCCCD
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm6
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x78(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %rbx
               	movss	-0x10(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movslq	%ebx, %rbx
               	cvtsi2sd	%rbx, %xmm6
               	leaq	-0x20(%rbp), %rbx
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%rbx,%riz)
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x40c81c4000000000, %rbx # imm = 0x40C81C4000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	movq	%rax, -0x80(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x40c81cc000000000, %rax # imm = 0x40C81CC000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	seta	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %r12
               	movss	-0x20(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %r12
               	movslq	%r12d, %r12
               	cvtsi2sd	%r12, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x30(%rbp)
               	movq	-0x30(%rbp), %r12
               	movabsq	$0x401e000000000000, %rax # imm = 0x401E000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r12, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r12b
               	movzbq	%r12b, %r12
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r12
               	movq	%r12, -0x88(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movabsq	$0x401a000000000000, %r12 # imm = 0x401A000000000000
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movq	-0x30(%rbp), %r12
               	movq	%r12, %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cvtsi2sd	%r12, %xmm7
               	leaq	-0x40(%rbp), %r12
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r12)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x41eff68690000000, %r12 # imm = 0x41EFF68690000000
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	movq	%rax, -0x90(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x41f004ccb0000000, %rax # imm = 0x41F004CCB0000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm6
               	seta	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %r14
               	movss	-0x40(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	movq	%r14, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400d99999999999a, %r14 # imm = 0x400D99999999999A
               	leaq	-0x48(%rbp), %rax
               	movq	%r14, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movss	-0x48(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	cvttsd2si	%xmm6, %rax
               	movslq	%eax, %r14
               	cmpq	$0x3, %r14
               	je	<addr>
               	leaq	<rip>, %r12
               	movslq	%eax, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4007333333333333, %rbx # imm = 0x4007333333333333
               	movq	%rbx, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	movq	%rbx, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movslq	%eax, %rbx
               	cmpq	$-0x2, %rbx
               	je	<addr>
               	leaq	<rip>, %r14
               	movslq	%eax, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
