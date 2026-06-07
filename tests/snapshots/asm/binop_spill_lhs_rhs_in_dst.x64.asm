
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	%edx, %rdx
               	movslq	(%rdi,%rdx,4), %rax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	cmpq	%rdx, %rcx
               	jg	<addr>
               	jmp	<addr>
               	movslq	%r8d, %r8
               	addq	$0x1, %r8
               	jmp	<addr>
               	movslq	%esi, %r9
               	movslq	%r8d, %rcx
               	movslq	(%rdi,%rcx,4), %rcx
               	addq	%rcx, %r9
               	movslq	%r9d, %rsi
               	jmp	<addr>
               	movslq	%esi, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	$0xc, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %edx
               	addq	$0x4, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	$0xf, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	addq	$0xc, %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	movl	$0xa, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
