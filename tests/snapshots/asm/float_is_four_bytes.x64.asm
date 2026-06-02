
float_is_four_bytes.x64:	file format elf64-x86-64

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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movq	0x20(%rbp), %r9
               	leaq	-0x10(%rbp), %r11
               	movq	%r9, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	movq	0x30(%rbp), %r11
               	leaq	-0x18(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	addsd	%xmm6, %xmm7
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm7, %xmm0
               	addsd	%xmm6, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rsi,%riz)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movq	%rsi, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x4, %rsi
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	%eax, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x4, %ebx
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r9
               	movq	%rsi, %rdi
               	movq	%r9, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	%ebx, -0x8(%rbp)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	subq	%rax, %rdi
               	cmpq	$0x4, %rdi
               	je	<addr>
               	leaq	<rip>, %r9
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	movq	%r9, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movss	(%rsi,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	movss	(%rdi,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm0
               	movq	%rax, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x8, %edi
               	movl	%edi, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	addq	$0x8, %rdi
               	movss	(%rdi,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x400c000000000000, %rdi # imm = 0x400C000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x9, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	addq	$0xc, %rdi
               	movss	(%rdi,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm0
               	movq	%rax, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0xa, %edi
               	movl	%edi, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
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
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xb, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
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
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xc, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	callq	<addr>
               	movq	%rbx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%bl
               	movzbq	%bl, %rbx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xd, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %rdx # imm = 0x400C000000000000
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	movabsq	$0x401a000000000000, %rdx # imm = 0x401A000000000000
               	movq	%rdi, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %r12
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rdi, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %rdi
               	movq	%rsi, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %rsi
               	movq	%rax, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0xe, %edx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	leaq	-0x30(%rbp), %rax
               	movq	%rdx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	leaq	-0x38(%rbp), %rdx
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdx,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x38(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	mulsd	%xmm6, %xmm7
               	movabsq	$0x3fd0000000000000, %rdx # imm = 0x3FD0000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm7
               	leaq	-0x40(%rbp), %rdx
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rdx,%riz)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x400a000000000000, %rdx # imm = 0x400A000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm6, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xf, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	leaq	-0x48(%rbp), %rdi
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x3f800000, %rax       # imm = 0x3F800000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x50(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
