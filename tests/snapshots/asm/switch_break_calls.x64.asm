
switch_break_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ee <.text+0xce>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x64, %eax
               	retq
               	movl	$0xc8, %eax
               	retq
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq
               	movl	$0x190, %eax            # imm = 0x190
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002c2 <.text+0xa2>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400237 <.text+0x17>
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400272 <.text+0x52>
               	callq	0x40023d <.text+0x1d>
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400272 <.text+0x52>
               	callq	0x400243 <.text+0x23>
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400272 <.text+0x52>
               	callq	0x400249 <.text+0x29>
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400272 <.text+0x52>
               	cmpq	$0x0, %r11
               	je	0x40028e <.text+0x6e>
               	cmpq	$0x1, %r11
               	je	0x40029b <.text+0x7b>
               	cmpq	$0x2, %r11
               	je	0x4002a8 <.text+0x88>
               	jmp	0x4002b5 <.text+0x95>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	0x40024f <.text+0x2f>
               	addb	%al, 0x41(%rdx)
