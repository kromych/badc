
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
               	subq	$0x90, %rsp
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
               	leaq	-0x8(%rbp), %r11
               	movzbq	(%r11), %r11
               	cvtsi2sd	%r11, %xmm7
               	leaq	-0x10(%rbp), %r11
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4044f33333333333, %r11 # imm = 0x4044F33333333333
               	movq	%r11, %xmm15
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
               	seta	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x78(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	<rip>, %rdi
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm6, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %edi           # imm = 0x3039
               	cvtsi2sd	%rdi, %xmm6
               	leaq	-0x20(%rbp), %rdi
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x40c81c4000000000, %rdi # imm = 0x40C81C4000000000
               	movq	%rdi, %xmm15
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
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm0
               	movq	%rax, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movabsq	$0x401e000000000000, %rdi # imm = 0x401E000000000000
               	movq	%rdi, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	movq	%rax, -0x88(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rdi
               	movabsq	$0x401a000000000000, %rax # imm = 0x401A000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rdi, %xmm14
               	ucomisd	%xmm7, %xmm14
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	-0x30(%rbp), %rsi
               	movq	%rsi, %xmm0
               	movq	%rax, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	cvtsi2sd	%rsi, %xmm7
               	leaq	-0x40(%rbp), %rsi
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rsi,%riz)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x41eff68690000000, %rsi # imm = 0x41EFF68690000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	movq	%r8, -0x90(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x41f004ccb0000000, %r8 # imm = 0x41F004CCB0000000
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm6
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm6, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400d99999999999a, %rdi # imm = 0x400D99999999999A
               	leaq	-0x48(%rbp), %rax
               	movq	%rdi, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movss	-0x48(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	cvttsd2si	%xmm6, %rax
               	movslq	%eax, %rdi
               	cmpq	$0x3, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4007333333333333, %rdi # imm = 0x4007333333333333
               	movq	%rdi, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x58(%rbp)
               	movq	-0x58(%rbp), %rdi
               	movq	%rdi, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movslq	%eax, %rdi
               	cmpq	$-0x2, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
