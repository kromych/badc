
mem2reg_narrow_store_trunc.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400291 <.text+0x71>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	andq	$0xff, %r11
               	xorq	$0x2c, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	jne	0x400275 <.text+0x55>
               	xorq	%r9, %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x400284 <.text+0x64>
               	movl	$0x1, %r9d
               	movq	%r9, -0x10(%rbp)
               	jmp	0x400284 <.text+0x64>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x12c, %ebx            # imm = 0x12C
               	movq	%rbx, %rdi
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	0x400237 <.text+0x17>
               	addb	%al, (%rax)
