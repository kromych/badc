
float_is_four_bytes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x3fc00000, %r12d      # imm = 0x3FC00000
               	movq	%r12, %xmm14
               	movss	%xmm14, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	movq	%r12, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %ebx
               	leaq	<rip>, %rax
               	leaq	0x4(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movq	%rcx, %rsi
               	subq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %ebx
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	movq	%r12, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ebx
               	leaq	<rip>, %rax
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %r13d      # imm = 0x40200000
               	movq	%r13, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	0x4(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ebx
               	leaq	<rip>, %rax
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40600000, %r14d      # imm = 0x40600000
               	movq	%r14, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	0x8(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x9, %ebx
               	leaq	<rip>, %rax
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	0xc(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xa, %ebx
               	movq	%r12, %xmm14
               	movq	%r12, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xb, %ebx
               	movq	%r13, %xmm14
               	movq	%r13, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xc, %ebx
               	movq	%r12, %xmm14
               	movq	%r13, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xd, %ebx
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addss	%xmm15, %xmm0
               	movq	%r14, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movl	$0x40d00000, %edx       # imm = 0x40D00000
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm1, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xe, %ebx
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x28(%rbp,%riz)
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x18(%rbp,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movss	-0x18(%rbp,%riz), %xmm1
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%rax, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x40500000, %eax       # imm = 0x40500000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xf, %ebx
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x10(%rbp,%riz)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x8(%rbp), %eax
               	xorq	$0x3f800000, %rax       # imm = 0x3F800000
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x8(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ebx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
