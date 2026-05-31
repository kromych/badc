
file_io.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400347 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfd9c(%rip), %rbx      # 0x410108
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400567 <open>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movslq	%r14d, %r12
               	cmpq	$0x0, %r12
               	jge	0x4003b9 <.text+0x89>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x40056d <malloc>
               	movq	%rax, %r12
               	movslq	%r14d, %rbx
               	movl	$0x9, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400573 <read>
               	movslq	%eax, %rax
               	addq	$0x9, %r12
               	xorq	%rbx, %rbx
               	movb	%bl, (%r12)
               	movslq	%r14d, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x400579 <close>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
