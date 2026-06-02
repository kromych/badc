
unsigned_div_in_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movq	(%r11), %r9
               	movl	$0x18, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	(%r11), %r11
               	movl	$0x7, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %r11
               	popq	%rdx
               	popq	%rax
               	movslq	%r9d, %r9
               	movl	$0x64, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r9
               	movl	$0x18, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	(%r11), %r11
               	movl	$0x7, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %r11
               	popq	%rdx
               	popq	%rax
               	movslq	%r9d, %r9
               	movl	$0x64, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x3ea, %r9             # imm = 0x3EA
               	jne	<addr>
               	xorq	%r11, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r11d
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
