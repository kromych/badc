
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400317 <.text+0xf7>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movq	%r11, %rax
               	addq	$0x7, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movq	%r9, %rax
               	addq	$0x1, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	-0x4b(%rip), %r12       # 0x400237 <.text+0x17>
               	xorq	%r8, %r8
               	movq	%r8, -0x10(%rbp)
               	movq	%r8, -0x18(%rbp)
               	jmp	0x400292 <.text+0x72>
               	movq	-0x18(%rbp), %r8
               	cmpq	%rbx, %r8
               	jge	0x4002f1 <.text+0xd1>
               	movq	-0x10(%rbp), %r14
               	movq	-0x18(%rbp), %r15
               	movq	%r15, %rdi
               	callq	0x400245 <.text+0x25>
               	movq	%rax, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movq	%r15, -0x10(%rbp)
               	movq	-0x10(%rbp), %r14
               	movq	-0x18(%rbp), %r15
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movq	%r15, -0x10(%rbp)
               	movq	-0x18(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x1, %r15
               	movq	%r15, -0x18(%rbp)
               	jmp	0x400292 <.text+0x72>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	0x40025a <.text+0x3a>
               	movq	%rax, %r9
               	movq	%r9, %rbx
               	andq	$0x7f, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
