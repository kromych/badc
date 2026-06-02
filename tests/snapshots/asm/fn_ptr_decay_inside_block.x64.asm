
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	addq	$0x64, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x1, %r9d
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	leaq	-<rip>, %rbx       # <addr>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x1, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%rax, %r14
               	movl	%r14d, (%r12)
               	leaq	-0x8(%rbp), %r15
               	movslq	(%r15), %r12
               	movl	$0x2, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%rax, %r12
               	movl	%r12d, (%r15)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r15
               	movl	$0x3, %edi
               	movq	-0x30(%rbp), %r12
               	movq	%r12, %r11
               	callq	*%r11
               	addq	%rax, %r15
               	movl	%r15d, (%rbx)
               	jmp	<addr>
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %rbx
               	leaq	-0x48(%rbp), %r15
               	movq	(%r15), %r15
               	movl	$0x4, %edi
               	movq	%r15, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	movl	%ebx, (%r12)
               	movslq	-0x8(%rbp), %r12
               	cmpq	$0x19a, %r12            # imm = 0x19A
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
