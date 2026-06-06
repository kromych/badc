
param_fp_before_int_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	leaq	-0x8(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x10(%rbp), %rax
               	movapd	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	movslq	%eax, %rax
               	imulq	$0x2710, %rsi, %rsi     # imm = 0x2710
               	movslq	%esi, %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	movslq	%edx, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movslq	(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	0x70(%rbp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x80, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	movapd	%xmm0, %xmm1
               	callq	<addr>
               	cmpq	$0x1e361, %rax          # imm = 0x1E361
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
