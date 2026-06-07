
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	retq
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x7, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	movslq	%r12d, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	movslq	%r12d, %rax
               	imulq	$0x6, %rax, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
