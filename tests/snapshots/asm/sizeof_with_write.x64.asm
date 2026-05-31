
sizeof_with_write.x64:	file format elf64-x86-64

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
               	movl	$0x10, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400497 <malloc>
               	movq	%rax, %r12
               	movl	$0x1, %r14d
               	movl	%r14d, (%r12)
               	movq	%r12, %rdi
               	addq	$0x4, %rdi
               	movl	$0x2, %esi
               	movl	%esi, (%rdi)
               	movq	%r12, %rdx
               	addq	$0x8, %rdx
               	leaq	0xfdda(%rip), %rsi      # 0x4100f8
               	movq	%rsi, (%rdx)
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40049d <write>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
