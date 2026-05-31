
warn_dead_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002bd <.text+0x9d>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x1, %eax
               	retq
               	movl	$0x5, %r11d
               	movslq	%r11d, %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	je	0x40028b <.text+0x6b>
               	movl	$0x2, %r8d
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x40028b <.text+0x6b>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rbx
               	callq	0x40023d <.text+0x1d>
               	movq	%rbx, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r12
               	movl	$0x1, %r14d
               	movq	%r14, %rdi
               	callq	0x400257 <.text+0x37>
               	movq	%r12, %r14
               	addq	%rax, %r14
               	movslq	%r14d, %rbx
               	callq	0x400298 <.text+0x78>
               	movq	%rbx, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
