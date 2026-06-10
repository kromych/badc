
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
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
               	movslq	%r8d, %rcx
               	movq	%rcx, %r8
               	incq	%r8
               	jmp	<addr>
               	movslq	%esi, %rcx
               	movslq	%r8d, %rsi
               	movslq	(%rdi,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rsi
               	jmp	<addr>
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
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
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xf, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xa, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
