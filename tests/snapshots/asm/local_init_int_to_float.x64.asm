
local_init_int_to_float.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movabsq	$0x4044f33333333333, %rax # imm = 0x4044F33333333333
               	movsd	0x28(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%bl
               	movzbq	%bl, %rbx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movabsq	$0x40450ccccccccccd, %rax # imm = 0x40450CCCCCCCCCCD
               	movsd	0x28(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movsd	0x28(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %eax           # imm = 0x3039
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movabsq	$0x40c81c4000000000, %rax # imm = 0x40C81C4000000000
               	movsd	0x20(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%bl
               	movzbq	%bl, %rbx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movabsq	$0x40c81cc000000000, %rax # imm = 0x40C81CC000000000
               	movsd	0x20(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movsd	0x20(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rax
               	cvtsi2sd	%rax, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movabsq	$0x401e000000000000, %rax # imm = 0x401E000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x18(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	setb	%bl
               	movzbq	%bl, %rbx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movabsq	$0x401a000000000000, %rax # imm = 0x401A000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x18(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	seta	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movsd	0x18(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movabsq	$0x41eff68690000000, %rax # imm = 0x41EFF68690000000
               	movsd	0x10(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%bl
               	movzbq	%bl, %rbx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movabsq	$0x41f004ccb0000000, %rax # imm = 0x41F004CCB0000000
               	movsd	0x10(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movsd	0x10(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400d99999999999a, %rax # imm = 0x400D99999999999A
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4007333333333333, %rax # imm = 0x4007333333333333
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rcx
               	cmpq	$-0x2, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
