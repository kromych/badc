
write_stdout.x64:	file format elf64-x86-64

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
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004b7 <malloc>
               	movq	%rax, %r12
               	xorq	%r14, %r14
               	movl	$0x68, %r8d
               	movb	%r8b, (%r12)
               	movl	$0x1, %ebx
               	movq	%r12, %r8
               	addq	$0x1, %r8
               	movl	$0x69, %esi
               	movb	%sil, (%r8)
               	movq	%r12, %rdx
               	addq	$0x2, %rdx
               	movl	$0xa, %esi
               	movb	%sil, (%rdx)
               	movl	$0x3, %r15d
               	movq	%r12, %rsi
               	addq	$0x3, %rsi
               	movb	%r14b, (%rsi)
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4004bd <write>
               	movslq	%eax, %rax
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
