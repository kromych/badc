
hex_constant_unsigned_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movabsq	$-0x1, %r11
               	movslq	%r11d, %r9
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	xorq	%r9, %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r8, %r9
               	cmpq	$0x0, %r9
               	je	0x400269 <.text+0x49>
               	movl	$0x1, %eax
               	retq
               	movslq	%r11d, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorq	%r8, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400294 <.text+0x74>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	retq
               	movslq	%r11d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %r8
               	cmpq	%r11, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x4002c2 <.text+0xa2>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
