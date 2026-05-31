
memset_mcmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100e0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004c7 <malloc>
               	movq	%rax, %r12
               	movl	$0x41, %r14d
               	movl	$0x4, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4004cd <memset>
               	movq	%rax, %rdi
               	movq	%r12, %rdi
               	addq	$0x4, %rdi
               	xorq	%rbx, %rbx
               	movb	%bl, (%rdi)
               	movzbq	(%r12), %r14
               	movq	%r14, %r12
               	xorq	$0x41, %r12
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r12, %r14
               	cmpq	$0x0, %r14
               	jne	0x400368 <.text+0xb8>
               	movl	$0x2a, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
