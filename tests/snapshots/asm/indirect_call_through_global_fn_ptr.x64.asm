
indirect_call_through_global_fn_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002dc <.text+0xbc>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r11)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe63(%rip), %r11      # 0x4100d8
               	movl	$0x7, %r9d
               	movl	%r9d, (%r11)
               	leaq	0xfe5b(%rip), %r8       # 0x4100e0
               	movl	$0x23, %r9d
               	movl	%r9d, (%r8)
               	leaq	0xfe3b(%rip), %rbx      # 0x4100d0
               	movslq	(%r11), %r12
               	movslq	(%r8), %r14
               	leaq	0xfe46(%rip), %r8       # 0x4100e8
               	movq	(%r8), %r15
               	movq	%r15, %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	*%r11
               	movq	%rax, %r8
               	movslq	(%rbx), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	0x400250 <.text+0x30>
               	addb	%al, 0x41(%rdx)
