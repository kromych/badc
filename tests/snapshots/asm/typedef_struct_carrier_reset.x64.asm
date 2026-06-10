
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<zero_and_sum>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%eax, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movl	%edx, (%rdi,%rdx,4)
               	movq	%rdi, %rdx
               	addq	$0x28, %rdx
               	movslq	%eax, %rsi
               	movq	%rsi, %r8
               	incq	%r8
               	movl	%r8d, (%rdx,%rsi,4)
               	movslq	%ecx, %rcx
               	movslq	%eax, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdi, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rsi
               	movq	%rdi, %r8
               	addq	$0x28, %r8
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movl	%eax, 0xa0(%rdi)
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x3c(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0xa0(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
